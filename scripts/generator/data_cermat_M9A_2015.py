# -*- coding: utf-8 -*-
# CERMAT – přijímací zkoušky 2015 (pilotní ročník), MATEMATIKA 9 (čtyřleté obory).
# Kód testu: M9PZD15C0T01. 17 úloh, 50 bodů, 60 minut.
# Po rozdělení nezávislých podúloh (3.1/3.2, 4.1/4.2, 7.1/7.2) je zde 20 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), struktura ověřena záznamovým archem (VZA).

# ---- SVG obrázky (bez apostrofu a zpětného lomítka) ----

# úloha 8: síť kvádru – pás 4 stěn + horní a dolní chlopeň, body A,0,B,C,D,E,2,F,G,H,1,K,3,L
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif" font-size="15">
<rect x="60" y="90" width="60" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<rect x="120" y="90" width="100" height="110" fill="#ffffff" stroke="#000" stroke-width="2"/>
<rect x="220" y="90" width="60" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<rect x="280" y="90" width="100" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<rect x="120" y="30" width="100" height="60" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<rect x="120" y="200" width="100" height="60" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<text x="112" y="26" text-anchor="end" font-style="italic">A</text>
<circle cx="240" cy="20" r="11" fill="#fff" stroke="#000"/><text x="240" y="25" text-anchor="middle" font-weight="bold">0</text>
<text x="54" y="84" text-anchor="end" font-style="italic">B</text>
<text x="114" y="84" text-anchor="end" font-style="italic">C</text>
<text x="214" y="84" text-anchor="end" font-style="italic">D</text>
<text x="288" y="84" font-style="italic">E</text>
<circle cx="392" cy="74" r="11" fill="#fff" stroke="#000"/><text x="392" y="79" text-anchor="middle" font-weight="bold">2</text>
<text x="54" y="220" text-anchor="end" font-style="italic">F</text>
<text x="114" y="220" text-anchor="end" font-style="italic">G</text>
<text x="214" y="220" text-anchor="end" font-style="italic">H</text>
<circle cx="292" cy="222" r="11" fill="#fff" stroke="#000"/><text x="292" y="227" text-anchor="middle" font-weight="bold">1</text>
<text x="390" y="220" font-style="italic">K</text>
<circle cx="106" cy="274" r="11" fill="#fff" stroke="#000"/><text x="106" y="279" text-anchor="middle" font-weight="bold">3</text>
<text x="228" y="279" font-style="italic">L</text>
</svg>"""

# úloha 9: různoběžky o, p a bod A na přímce p
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif" font-size="15">
<line x1="40" y1="40" x2="420" y2="120" stroke="#000" stroke-width="2"/>
<text x="428" y="126" font-style="italic">o</text>
<line x1="40" y1="40" x2="330" y2="185" stroke="#000" stroke-width="2"/>
<text x="338" y="194" font-style="italic">p</text>
<line x1="289" y1="158" x2="284" y2="169" stroke="#000" stroke-width="2"/>
<text x="272" y="180" text-anchor="end" font-style="italic">A</text>
</svg>"""

# úloha 10: body A, B, Y
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 200" font-family="sans-serif" font-size="15">
<line x1="394" y1="39" x2="406" y2="51" stroke="#000" stroke-width="2"/><line x1="406" y1="39" x2="394" y2="51" stroke="#000" stroke-width="2"/>
<text x="400" y="30" text-anchor="middle" font-style="italic">B</text>
<line x1="114" y1="74" x2="126" y2="86" stroke="#000" stroke-width="2"/><line x1="126" y1="74" x2="114" y2="86" stroke="#000" stroke-width="2"/>
<text x="120" y="66" text-anchor="middle" font-style="italic">Y</text>
<line x1="144" y1="149" x2="156" y2="161" stroke="#000" stroke-width="2"/><line x1="156" y1="149" x2="144" y2="161" stroke="#000" stroke-width="2"/>
<text x="150" y="180" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 11: čtverec, čtverec s trojúhelníkem, nový obrazec
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" font-family="sans-serif" font-size="13">
<rect x="30" y="70" width="110" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<text x="85" y="128" text-anchor="middle" font-style="italic">o = 40 cm</text>
<rect x="200" y="70" width="110" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<polygon points="200,180 310,180 252,108" fill="#ffffff" stroke="#000" stroke-width="2"/>
<text x="262" y="174" text-anchor="middle" font-style="italic">o = 25 cm</text>
<polygon points="380,70 435,10 490,70 490,180 435,110 380,180" fill="#d3d3d3" stroke="#000" stroke-width="2"/>
<line x1="380" y1="180" x2="490" y2="180" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="437" y1="176" x2="437" y2="48" stroke="#888" stroke-width="1.5"/>
<polygon points="437,36 431,52 443,52" fill="#888"/>
</svg>"""

# úloha 13: trojúhelník s vnějším úhlem 90 stupňů + alfa
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif" font-size="15">
<line x1="30" y1="160" x2="440" y2="160" stroke="#000" stroke-width="2"/>
<line x1="100" y1="160" x2="223.6" y2="36.4" stroke="#000" stroke-width="2"/>
<line x1="223.6" y1="36.4" x2="400" y2="160" stroke="#000" stroke-width="2"/>
<path d="M 38 160 A 62 62 0 0 1 143.8 116.2" fill="none" stroke="#000"/>
<path d="M 134 160 A 34 34 0 0 0 124 136" fill="none" stroke="#000"/>
<path d="M 366 160 A 34 34 0 0 1 372.2 140.5" fill="none" stroke="#000"/>
<path d="M 248.2 53.6 A 30 30 0 0 1 202.4 57.6" fill="none" stroke="#000"/>
<text x="72" y="140" text-anchor="middle">90° + α</text>
<text x="118" y="155" font-style="italic">α</text>
<text x="360" y="152" text-anchor="end">35°</text>
<text x="222" y="76" text-anchor="middle" font-style="italic">γ</text>
</svg>"""

# úloha 14: kružnice z drátu a obdélník
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 180" font-family="sans-serif">
<circle cx="105" cy="90" r="65" fill="none" stroke="#000" stroke-width="2"/>
<rect x="265" y="52" width="150" height="76" fill="none" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 17: tabulky – počty večeří a průměrné ceny ve skupinách
SVG17 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 250" font-family="sans-serif" font-size="13">
<rect x="20" y="15" width="520" height="145" fill="none" stroke="#000" stroke-width="2"/>
<line x1="150" y1="15" x2="150" y2="160" stroke="#000" stroke-width="2"/>
<line x1="220" y1="43" x2="220" y2="160" stroke="#000"/>
<line x1="290" y1="43" x2="290" y2="160" stroke="#000"/>
<line x1="360" y1="15" x2="360" y2="160" stroke="#000" stroke-width="2"/>
<line x1="150" y1="43" x2="360" y2="43" stroke="#000"/>
<line x1="20" y1="71" x2="540" y2="71" stroke="#000" stroke-width="2"/>
<line x1="20" y1="101" x2="540" y2="101" stroke="#000"/>
<line x1="20" y1="131" x2="540" y2="131" stroke="#000"/>
<text x="255" y="35" text-anchor="middle" font-weight="bold">Počet večeří</text>
<text x="450" y="31" text-anchor="middle">Průměrná cena večeře</text>
<text x="450" y="53" text-anchor="middle">ve skupině</text>
<text x="185" y="64" text-anchor="middle" font-weight="bold">A</text>
<text x="255" y="64" text-anchor="middle" font-weight="bold">B</text>
<text x="325" y="64" text-anchor="middle" font-weight="bold">C</text>
<text x="85" y="92" text-anchor="middle" font-weight="bold">Skupina 1</text>
<text x="185" y="92" text-anchor="middle">20</text><text x="255" y="92" text-anchor="middle">0</text><text x="325" y="92" text-anchor="middle">0</text>
<text x="450" y="92" text-anchor="middle">200 Kč</text>
<text x="85" y="122" text-anchor="middle" font-weight="bold">Skupina 2</text>
<text x="185" y="122" text-anchor="middle">10</text><text x="255" y="122" text-anchor="middle">10</text><text x="325" y="122" text-anchor="middle">0</text>
<text x="450" y="122" text-anchor="middle">240 Kč</text>
<text x="85" y="152" text-anchor="middle" font-weight="bold">Skupina 3</text>
<text x="185" y="152" text-anchor="middle">5</text><text x="255" y="152" text-anchor="middle">5</text><text x="325" y="152" text-anchor="middle">10</text>
<text x="450" y="152" text-anchor="middle">270 Kč</text>
<rect x="20" y="180" width="340" height="60" fill="none" stroke="#000" stroke-width="2"/>
<line x1="150" y1="180" x2="150" y2="240" stroke="#000" stroke-width="2"/>
<line x1="220" y1="180" x2="220" y2="240" stroke="#000"/>
<line x1="290" y1="180" x2="290" y2="240" stroke="#000"/>
<line x1="20" y1="210" x2="360" y2="210" stroke="#000" stroke-width="2"/>
<text x="185" y="202" text-anchor="middle" font-weight="bold">A</text>
<text x="255" y="202" text-anchor="middle" font-weight="bold">B</text>
<text x="325" y="202" text-anchor="middle" font-weight="bold">C</text>
<text x="85" y="231" text-anchor="middle" font-weight="bold">Cena večeře</text>
</svg>"""

B = ['zs2', 'r9']  # 2. stupeň ZŠ, 9. ročník (přijímačky na čtyřleté obory)

PROBLEMS = [
    {'name':'CERMAT M9A 2015 – úloha 1','zad':[
        'Vypočtěte: $20-3\\cdot (30-30:2)=$'],'opts':None,'ln':2,
     'sol':['Nejprve závorka: $30-30:2=30-15=15$.','Potom $20-3\\cdot 15=20-45=-25$.'],
     'ans':'$-25$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 2','zad':[
        'Zapište zlomkem v základním tvaru jednu šestinu rozdílu $2{,}4-1{,}5$.'],'opts':None,'ln':2,
     'sol':['Rozdíl je $2{,}4-1{,}5=0{,}9$.',
            'Jedna šestina: $0{,}9:6=0{,}15=\\frac{15}{100}=\\frac{3}{20}$.'],
     'ans':'$\\frac{3}{20}$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\frac{1}{6}+\\frac{2}{3}\\cdot\\frac{9}{8}=$'],'opts':None,'ln':3,
     'sol':['Nejprve násobení: $\\frac{2}{3}\\cdot\\frac{9}{8}=\\frac{18}{24}=\\frac{3}{4}$.',
            'Potom sčítání: $\\frac{1}{6}+\\frac{3}{4}=\\frac{2}{12}+\\frac{9}{12}=\\frac{11}{12}$.'],
     'ans':'$\\frac{11}{12}$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\frac{2}{3}:\\frac{5}{2}-\\frac{2}{3}=$'],'opts':None,'ln':3,
     'sol':['Nejprve dělení: $\\frac{2}{3}:\\frac{5}{2}=\\frac{2}{3}\\cdot\\frac{2}{5}=\\frac{4}{15}$.',
            'Potom odčítání: $\\frac{4}{15}-\\frac{2}{3}=\\frac{4}{15}-\\frac{10}{15}=-\\frac{6}{15}=-\\frac{2}{5}$.'],
     'ans':'$-\\frac{2}{5}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 4.1','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$2x(x-3)-(x^2+3x)=$'],'opts':None,'ln':3,
     'sol':['Roznásobíme: $2x(x-3)=2x^2-6x$ a odstraníme závorku se znaménkem minus: $-(x^2+3x)=-x^2-3x$.',
            'Sečteme podobné členy: $2x^2-6x-x^2-3x=x^2-9x$.'],
     'ans':'$x^2-9x$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 4.2','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$(2+y)(y+2-2y)=$'],'opts':None,'ln':3,
     'sol':['V druhé závorce sečteme členy s $y$: $y+2-2y=2-y$.',
            'Podle vzorce pro rozdíl druhých mocnin: $(2+y)(2-y)=4-y^2$.'],
     'ans':'$4-y^2$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 5','zad':[
        'Řešte rovnici:',
        '$\\frac{2-x}{2}-3=\\frac{2x+1}{3}$'],'opts':None,'ln':4,
     'sol':['Obě strany vynásobíme šesti: $3(2-x)-18=2(2x+1)$.',
            '$6-3x-18=4x+2$, tedy $-3x-12=4x+2$.',
            '$-14=7x$, odtud $x=-2$.'],
     'ans':'$x=-2$','pts':3,'mins':4,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 6','zad':[
        'Turistická trasa je na mapě s měřítkem $1:50\\,000$ zobrazena čarou dlouhou $30$ cm.',
        '6.1 Vypočtěte v km skutečnou délku turistické trasy.',
        '6.2 Vypočtěte v cm délku čáry, která zobrazuje stejnou turistickou trasu na mapě s měřítkem $1:60\\,000$.'],
     'opts':None,'ln':3,
     'sol':['6.1 Skutečná délka je $30\\cdot 50\\,000=1\\,500\\,000$ cm $=15\\,000$ m $=15$ km.',
            '6.2 Na mapě $1:60\\,000$ je délka čáry $1\\,500\\,000:60\\,000=25$ cm.'],
     'ans':'6.1: $15$ km; 6.2: $25$ cm','pts':4,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2015 – úloha 7.1','zad':[
        'Vypočítejte a výsledek vyjádřete v uvedených jednotkách.',
        '$1{,}5$ dm² $+\\,75$ mm² $=$ __________ mm²'],'opts':None,'ln':2,
     'sol':['Platí $1$ dm² $=10\\,000$ mm², tedy $1{,}5$ dm² $=15\\,000$ mm².',
            '$15\\,000+75=15\\,075$ mm².'],
     'ans':'$15\\,075$ mm²','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 7.2','zad':[
        'Vypočítejte a výsledek vyjádřete v uvedených jednotkách.',
        '$1$ m³ $-\\,50$ litrů $=$ __________ litrů'],'opts':None,'ln':2,
     'sol':['Platí $1$ m³ $=1\\,000$ litrů.','$1\\,000-50=950$ litrů.'],
     'ans':'$950$ litrů','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 8','zad':[
        'Některé z bodů vyznačených v síti kvádru představují ve složeném kvádru jeden a týž vrchol. Například dva různé body $0$ a $E$ sítě kvádru představují ve složeném kvádru stejný vrchol.',
        'Připište k uvedenému bodu všechny body sítě kvádru, které ve složeném kvádru představují stejný vrchol.',
        '8.1 bod $1$','8.2 bod $2$','8.3 bod $3$'],'opts':None,'ln':3,
     'svg':SVG8,'fn':'sit-kvadru.svg',
     'alt':'Síť kvádru: vodorovný pás čtyř stěn s body B, C, D, E, 2 v horní hraně a F, G, H, 1, K v dolní hraně, nad druhou stěnou chlopeň s body A a 0, pod ní chlopeň s body 3 a L.',
     'cap':'Síť kvádru s vyznačenými body',
     'sol':['Pás se ohne kolem kvádru: stěna $CDHG$ je přední, $BCGF$ levá, $DE1H$ pravá a $E2K1$ zadní; horní chlopeň $ACD0$ je horní podstava, dolní chlopeň $G3LH$ dolní podstava.',
            '8.1 Bod $1$ je zadní dolní vrchol vpravo; stejný vrchol představuje bod $L$ z dolní podstavy.',
            '8.2 Bod $2$ je zadní horní vrchol vlevo; stejný vrchol představují body $A$ (horní podstava) a $B$ (levá stěna).',
            '8.3 Bod $3$ je zadní dolní vrchol vlevo; stejný vrchol představují body $F$ a $K$.'],
     'ans':'8.1: $L$; 8.2: $A$, $B$; 8.3: $F$, $K$','pts':3,'mins':5,'diff':'4',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 9 (konstrukce)','zad':[
        'V rovině leží různoběžky $o$, $p$ a bod $A$ na přímce $p$ (viz obrázek).',
        '9.1 Sestrojte bod $B$, který je obrazem bodu $A$ v osové souměrnosti s osou $o$.',
        '9.2 Sestrojte přímku $q$, která je obrazem přímky $p$ v osové souměrnosti s osou $o$.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'primky-op.svg',
     'alt':'Dvě různoběžné přímky o a p protínající se vlevo nahoře a bod A ležící na přímce p.',
     'cap':'Výchozí obrázek k úloze 9',
     'sol':['9.1 Bodem $A$ vedeme kolmici k ose $o$ a označíme patu kolmice $P$. Bod $B$ leží na této kolmici na opačné straně osy tak, že $|PB|=|AP|$.',
            '9.2 Průsečík $S$ přímek $o$ a $p$ je samodružný bod. Obraz $q$ přímky $p$ je proto přímka procházející body $S$ a $B$.'],
     'ans':'Bod $B$ je obraz bodu $A$ v osové souměrnosti podle osy $o$ (leží na kolmici z $A$ k ose ve stejné vzdálenosti od osy); přímka $q$ prochází průsečíkem přímek $o$ a $p$ a bodem $B$ – viz obrázek v klíči.',
     'pts':2,'mins':5,'diff':'3',
     'codes':B+['planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 10 (konstrukce)','zad':[
        'V rovině leží body $A$, $B$ a $Y$ (viz obrázek).',
        '10.1 Na polopřímce $BY$ sestrojte bod $C$ tak, aby body $A$, $B$, $C$ tvořily vrcholy rovnoramenného trojúhelníku se základnou $AB$, a trojúhelník $ABC$ narýsujte.',
        '10.2 Sestrojte osu souměrnosti $o$ trojúhelníku $ABC$.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'body-ABY.svg',
     'alt':'Tři body v rovině označené křížky a písmeny A, B a Y.',
     'cap':'Výchozí obrázek k úloze 10',
     'sol':['10.1 V rovnoramenném trojúhelníku se základnou $AB$ platí $|CA|=|CB|$, vrchol $C$ tedy leží na ose úsečky $AB$. Bod $C$ je průsečík osy úsečky $AB$ s polopřímkou $BY$.',
            '10.2 Osou souměrnosti rovnoramenného trojúhelníku $ABC$ je osa základny $AB$, tj. přímka procházející vrcholem $C$ a středem úsečky $AB$.'],
     'ans':'Bod $C$ je průsečík osy úsečky $AB$ s polopřímkou $BY$; osou souměrnosti $o$ je osa úsečky $AB$, která prochází bodem $C$ – viz obrázek v klíči.',
     'pts':3,'mins':6,'diff':'3',
     'codes':B+['planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 11','zad':[
        'Uvnitř čtverce je sestrojen trojúhelník, jehož jedna strana je současně stranou čtverce. Přemístěním trojúhelníku k protější straně čtverce vznikne nový obrazec. Obvod čtverce je $40$ cm a obvod trojúhelníku $25$ cm.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Obvod nového obrazce je $50$ cm.',
        '11.2 Obsah čtverce je $100$ cm².',
        '11.3 Obsah nového obrazce je větší než obsah čtverce.'],
     'opts':None,'ln':0,'svg':SVG11,'fn':'ctverec-trojuhelnik.svg',
     'alt':'Tři obrazce: čtverec s obvodem 40 cm, tentýž čtverec s trojúhelníkem o obvodu 25 cm uvnitř a nový obrazec se zářezem dole a hrotem nahoře.',
     'cap':'Čtverec, vepsaný trojúhelník a nový obrazec',
     'sol':['Strana čtverce je $40:4=10$ cm; je zároveň stranou trojúhelníku, takže obě ramena trojúhelníku mají dohromady $25-10=15$ cm.',
            '11.1 U nového obrazce nahradí dole ramena trojúhelníku ($15$ cm) spodní stranu čtverce a nahoře ramena ($15$ cm) přibudou; boční strany dají $2\\cdot 10=20$ cm. Obvod je $15+15+20=50$ cm → Ano.',
            '11.2 Obsah čtverce je $10\\cdot 10=100$ cm² → Ano.',
            '11.3 Trojúhelník byl pouze přemístěn, obsah nového obrazce je stejný jako obsah čtverce, není větší → Ne.'],
     'ans':'11.1: Ano; 11.2: Ano; 11.3: Ne','pts':3,'mins':5,'diff':'3',
     'codes':B+['planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 12','zad':[
        'V pravoúhlém trojúhelníku $ABC$ leží proti přeponě $c$ úhel $\\gamma$ a proti odvěsnám $a$, $b$ úhly $\\alpha$, $\\beta$. Platí: $a=6$ cm, $c=10$ cm.',
        'Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (A), či nikoli (N).',
        '12.1 $a+b=c$','12.2 $\\beta<\\gamma$','12.3 $\\alpha+\\beta=90^\\circ$'],
     'opts':None,'ln':0,
     'sol':['Podle Pythagorovy věty $b=\\sqrt{10^2-6^2}=\\sqrt{64}=8$ cm; proti přeponě leží pravý úhel, tedy $\\gamma=90^\\circ$.',
            '12.1 $6+8=14$, což se nerovná $10$ → Ne.',
            '12.2 Úhel $\\beta$ je ostrý, tedy $\\beta<90^\\circ=\\gamma$ → Ano.',
            '12.3 Součet ostrých úhlů pravoúhlého trojúhelníku je $180^\\circ-90^\\circ=90^\\circ$ → Ano.'],
     'ans':'12.1: Ne; 12.2: Ano; 12.3: Ano','pts':3,'mins':4,'diff':'3',
     'codes':B+['planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 13','zad':[
        'V trojúhelníku je u levého vrcholu vyznačen vnitřní úhel $\\alpha$ a k němu vedlejší (vnější) úhel o velikosti $90^\\circ+\\alpha$, u pravého vrcholu úhel $35^\\circ$ a u horního vrcholu úhel $\\gamma$ (viz obrázek).',
        'Jaká je velikost úhlu $\\gamma$?'],
     'opts':['A) $90^\\circ$','B) $95^\\circ$','C) $100^\\circ$','D) $105^\\circ$','E) jiná velikost'],
     'ln':0,'svg':SVG13,'fn':'trojuhelnik-uhly.svg',
     'alt':'Trojúhelník s vnějším úhlem 90 stupňů plus alfa u levého vrcholu, vnitřním úhlem alfa, úhlem 35 stupňů u pravého vrcholu a úhlem gama u vrcholu nahoře.',
     'cap':'Výchozí obrázek k úloze 13',
     'sol':['Vnitřní a vnější úhel u levého vrcholu tvoří přímý úhel: $(90^\\circ+\\alpha)+\\alpha=180^\\circ$, tedy $2\\alpha=90^\\circ$ a $\\alpha=45^\\circ$.',
            'Součet vnitřních úhlů trojúhelníku: $\\gamma=180^\\circ-45^\\circ-35^\\circ=100^\\circ$.'],
     'ans':'C) $100^\\circ$','pts':2,'mins':3,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 14','zad':[
        'Kružnice je vytvořena z drátu délky $30$ cm. Z tohoto drátu se vytvaruje obdélník, jehož sousední strany mají délky v poměru $3:2$.',
        'Jaký je obsah obdélníku?'],
     'opts':['A) $24$ cm²','B) $54$ cm²','C) $96$ cm²','D) $108$ cm²','E) jiný obsah'],
     'ln':0,'svg':SVG14,'fn':'kruznice-obdelnik.svg',
     'alt':'Kružnice a vedle ní obdélník, oba vytvořené ze stejného drátu.',
     'cap':'Výchozí obrázek k úloze 14',
     'sol':['Obvod obdélníku je roven délce drátu, tedy $30$ cm; součet dvou sousedních stran je $30:2=15$ cm.',
            'V poměru $3:2$ platí $3k+2k=15$, tedy $k=3$; strany jsou $9$ cm a $6$ cm.',
            'Obsah je $9\\cdot 6=54$ cm².'],
     'ans':'B) $54$ cm²','pts':2,'mins':3,'diff':'3',
     'codes':B+['planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2015 – úloha 15','zad':[
        'Karel s rodiči odlétal na dovolenou. Při odbavení na letišti měla jejich 3 zavazadla celkovou hmotnost $44$ kg. Otcovo zavazadlo mělo třikrát větší hmotnost než Karlovo zavazadlo a matčino zavazadlo mělo polovinu hmotnosti otcova zavazadla.',
        'O kolik kilogramů je matčino zavazadlo těžší než Karlovo zavazadlo?'],
     'opts':['A) o $3{,}5$ kg','B) o $4$ kg','C) o $5$ kg','D) o $6$ kg','E) o $6{,}5$ kg'],'ln':0,
     'sol':['Karlovo zavazadlo $k$, otcovo $3k$, matčino $\\frac{3k}{2}=1{,}5k$.',
            'Celkem $k+3k+1{,}5k=5{,}5k=44$, tedy $k=8$ kg.',
            'Matčino má $12$ kg, Karlovo $8$ kg, rozdíl je $12-8=4$ kg.'],
     'ans':'B) o $4$ kg','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2015 – úloha 16','zad':[
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Výrobek stojí $600$ korun. Kolik korun bude stát výrobek zdražený o $20\\,\\%$?',
        '16.2 Kalhoty byly zlevněny o $20\\,\\%$ na $560$ korun. Kolik korun stály kalhoty před zlevněním?',
        '16.3 Zájezd byl zdražen o pětinu na $3\\,600$ korun. O kolik korun byl zájezd zdražen?'],
     'opts':['A) $600$','B) $650$','C) $672$','D) $700$','E) $720$','F) jiný výsledek'],'ln':0,
     'sol':['16.1 Nová cena je $120\\,\\%$ původní: $600\\cdot 1{,}2=720$ korun → E.',
            '16.2 Cena po zlevnění je $80\\,\\%$ původní: $560:0{,}8=700$ korun → D.',
            '16.3 Cena po zdražení je $120\\,\\%$ původní: $3\\,600:1{,}2=3\\,000$ korun; zdraženo bylo o $3\\,600-3\\,000=600$ korun → A.'],
     'ans':'16.1: E ($720$); 16.2: D ($700$); 16.3: A ($600$)','pts':6,'mins':6,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2015 – úloha 17','zad':[
        'V motorestu se podávají tři různé večeře A, B, C. Do motorestu přijely tři 20členné skupiny. V tabulce je uvedeno, které večeře si jednotlivé skupiny objednaly a na kolik korun vyšla průměrná cena večeře v jednotlivých skupinách.',
        '17.1 Vypočtěte cenu večeře B.',
        '17.2 Vypočtěte cenu večeře C.'],
     'opts':None,'ln':4,'svg':SVG17,'fn':'tabulka-vecere.svg',
     'alt':'Tabulka s počty večeří A, B, C ve třech dvacetičlenných skupinách a průměrnou cenou večeře ve skupině; druhá tabulka pro doplnění cen večeří A, B, C.',
     'cap':'Počty večeří a průměrné ceny ve skupinách',
     'sol':['Skupina 1 si objednala pouze večeře A a průměrná cena je $200$ Kč, tedy večeře A stojí $200$ Kč.',
            '17.1 Skupina 2: $\\frac{10\\cdot 200+10\\cdot B}{20}=240$, tedy $2\\,000+10B=4\\,800$ a $B=280$ Kč.',
            '17.2 Skupina 3: $\\frac{5\\cdot 200+5\\cdot 280+10\\cdot C}{20}=270$, tedy $1\\,000+1\\,400+10C=5\\,400$ a $C=300$ Kč.'],
     'ans':'17.1: $280$ Kč; 17.2: $300$ Kč','pts':4,'mins':6,'diff':'4',
     'codes':B+['statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PZD15C0T01'
    gen.YEAR = 2015

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M9A' not in p['name']: errors.append('Chybí M9A v názvu: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    total_pts = sum(p['pts'] for p in PROBLEMS)
    if total_pts != 50: errors.append(f'Součet bodů {total_pts} != 50 (dle klíče)')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', total_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2015')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
