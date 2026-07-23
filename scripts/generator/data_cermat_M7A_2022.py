# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 7A (šestileté obory, 7. ročník), 1. řádný termín.
# Kód testu: M7PAD22C0T01. 16 úloh CERMAT, 50 bodů.
# Po rozdělení nezávislých poduúloh bez sdíleného kontextu (úlohy 3 a 4) -> 18 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 2: číselná osa, 11 dělicích bodů, dílek = 8; A=-16, B=32, C=48, D=56
def _osa():
    x0=40; step=36; y=90
    s=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 140" font-family="sans-serif">']
    s.append(f'<line x1="{x0-10}" y1="{y}" x2="440" y2="{y}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<polygon points="440,{y} 430,{y-5} 430,{y+5}" fill="#000"/>')
    for i in range(11):
        x=x0+i*step
        s.append(f'<line x1="{x}" y1="{y-7}" x2="{x}" y2="{y+7}" stroke="#000" stroke-width="1.5"/>')
    for i,lab in {1:'A',7:'B',9:'C',10:'D'}.items():
        x=x0+i*step
        s.append(f'<text x="{x}" y="{y+26}" font-size="15" text-anchor="middle" font-style="italic">{lab}</text>')
    xc=x0+9*step
    s.append(f'<text x="{xc}" y="{y-14}" font-size="14" text-anchor="middle">48</text>')
    s.append('</svg>')
    return "".join(s)
SVG2=_osa()

# úloha 6: schematická křivka cesty z domova do haly se dvěma časy
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 190" font-family="sans-serif">
<path d="M40,150 C110,70 170,80 240,120 C300,150 360,60 440,150" fill="none" stroke="#000" stroke-width="2"/>
<circle cx="40" cy="150" r="5" fill="#000"/>
<circle cx="200" cy="103" r="5" fill="#000"/>
<circle cx="330" cy="95" r="5" fill="#000"/>
<circle cx="440" cy="150" r="5" fill="#000"/>
<text x="40" y="172" font-size="13" text-anchor="middle">domov</text>
<text x="440" y="172" font-size="13" text-anchor="middle">hala</text>
<text x="200" y="90" font-size="13" text-anchor="middle">15:28</text>
<text x="330" y="82" font-size="13" text-anchor="middle">15:43</text>
</svg>"""

# úloha 7: skládaný sloupcový graf počtu nehod (A,B,C po čtvrtletích) + celoroční sloupec D
def _bars7():
    k=7.857; y0=250; x0=60; bw=44; gap=28
    fills=['url(#h7)','#9a9a9a','url(#d7)','#111']
    groups=[('A',[6,4,6,4]),('B',[4,6,4,2]),('C',[10,4,8,4])]
    s=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif">']
    s.append('<defs><pattern id="h7" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#fff"/><line x1="0" y1="0" x2="0" y2="6" stroke="#000" stroke-width="1.4"/></pattern><pattern id="d7" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1.1" fill="#000"/></pattern></defs>')
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="480" y2="{y0}" stroke="#000"/>')
    for v in range(0,29,4):
        y=y0-v*k
        s.append(f'<line x1="{x0-4}" y1="{y:.1f}" x2="{x0}" y2="{y:.1f}" stroke="#000"/><text x="{x0-8}" y="{y+4:.1f}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="18" y="140" font-size="12" text-anchor="middle" transform="rotate(-90 18 140)">Počet nehod</text>')
    x=x0+gap
    for name,vals in groups:
        yb=y0
        for i,val in enumerate(vals):
            h=val*k
            s.append(f'<rect x="{x:.0f}" y="{yb-h:.1f}" width="{bw}" height="{h:.1f}" fill="{fills[i]}" stroke="#000"/>')
            yb-=h
        s.append(f'<text x="{x+bw/2:.0f}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        x+=bw+gap
    hD=24*k
    s.append(f'<rect x="{x:.0f}" y="{y0-hD:.1f}" width="{bw}" height="{hD:.1f}" fill="#fff" stroke="#000"/>')
    s.append(f'<text x="{x+bw/2:.0f}" y="{y0+16}" font-size="12" text-anchor="middle">D</text>')
    lg=[('url(#h7)','1. čtvrtletí'),('#9a9a9a','2. čtvrtletí'),('url(#d7)','3. čtvrtletí'),('#111','4. čtvrtletí')]
    lx=70
    for fill,lab in lg:
        s.append(f'<rect x="{lx}" y="290" width="13" height="13" fill="{fill}" stroke="#000"/><text x="{lx+17}" y="301" font-size="11">{lab}</text>')
        lx+=108
    s.append('</svg>')
    return "".join(s)
SVG7=_bars7()

# úloha 8: výchozí obrázek – body A, D, R
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif">
<rect x="5" y="5" width="470" height="290" fill="none" stroke="#ccc"/>
<text x="150" y="108" font-size="15" text-anchor="middle">×</text><text x="150" y="124" font-size="16" text-anchor="middle" font-style="italic">D</text>
<text x="330" y="105" font-size="15" text-anchor="middle">×</text><text x="330" y="121" font-size="16" text-anchor="middle" font-style="italic">R</text>
<text x="200" y="225" font-size="15" text-anchor="middle">×</text><text x="200" y="241" font-size="16" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 9: výchozí obrázek – body P, S a přímka q
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif">
<rect x="5" y="5" width="470" height="310" fill="none" stroke="#ccc"/>
<line x1="60" y1="290" x2="430" y2="150" stroke="#000" stroke-width="2"/>
<text x="440" y="150" font-size="16" font-style="italic">q</text>
<text x="230" y="180" font-size="15" text-anchor="middle">×</text><text x="230" y="196" font-size="16" text-anchor="middle" font-style="italic">S</text>
<text x="140" y="235" font-size="15" text-anchor="middle">×</text><text x="140" y="251" font-size="16" text-anchor="middle" font-style="italic">P</text>
</svg>"""

# úloha 10: tři útvary – schematické znázornění (posouzení dle originálu)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif">
<text x="90" y="20" font-size="12" text-anchor="middle">1. útvar</text>
<polygon points="55,40 130,40 130,70 100,70 100,100 130,100 130,150 55,150 55,100 85,100 85,70 55,70" fill="#d0d0d0" stroke="#000"/>
<text x="255" y="20" font-size="12" text-anchor="middle">2. útvar</text>
<polygon points="200,45 250,45 260,72 305,60 305,110 272,122 278,162 236,150 220,120 200,112" fill="#d0d0d0" stroke="#000"/>
<text x="435" y="20" font-size="12" text-anchor="middle">3. útvar</text>
<polygon points="370,58 470,50 470,88 402,94 470,108 470,150 370,144 370,118 432,113 370,98" fill="#d0d0d0" stroke="#000"/>
</svg>"""

# úloha 11: dva rovnoramenné trojúhelníky se společnou stranou (dart s reflexním vrcholem)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 360" font-family="sans-serif">
<polygon points="180,30 40,180 250,330 170,175" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="40" y1="180" x2="170" y2="175" stroke="#000" stroke-width="1.5"/>
<text x="178" y="62" font-size="15" text-anchor="middle" font-style="italic">α</text>
<text x="108" y="168" font-size="14" font-style="italic">α</text>
<text x="72" y="196" font-size="13">40°</text>
<text x="158" y="150" font-size="15" font-style="italic">β</text>
<text x="150" y="205" font-size="13" font-style="italic">5α</text>
<text x="210" y="312" font-size="13">40°</text>
</svg>"""

# úlohy 12 a 13: kolmý trojboký hranol ABCDEF (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 240" font-family="sans-serif">
<polygon points="70,80 150,45 210,85" fill="#f2f2f2" stroke="#000" stroke-width="1.5"/>
<line x1="70" y1="80" x2="70" y2="200" stroke="#000" stroke-width="1.5"/>
<line x1="210" y1="85" x2="210" y2="205" stroke="#000" stroke-width="1.5"/>
<line x1="70" y1="200" x2="210" y2="205" stroke="#000" stroke-width="1.5"/>
<line x1="150" y1="45" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="70" y1="200" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="210" y1="205" x2="150" y2="165" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<text x="58" y="80" font-size="13" font-style="italic">D</text>
<text x="147" y="38" font-size="13" font-style="italic">F</text>
<text x="216" y="86" font-size="13" font-style="italic">E</text>
<text x="56" y="214" font-size="13" font-style="italic">A</text>
<text x="214" y="221" font-size="13" font-style="italic">B</text>
<text x="150" y="184" font-size="13" font-style="italic">C</text>
</svg>"""

# úloha 16: pyramidy z 1, 2, 3 a 4 řad, střídavě tmavé/bílé řady
def _pyr():
    cell=20; baseY=165; centers=[60,130,215,315]
    s=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 190" font-family="sans-serif">']
    for idx,rows in enumerate([1,2,3,4]):
        cx=centers[idx]
        for r in range(1,rows+1):
            fill='#9a9a9a' if (r%2==1) else '#ffffff'
            startx=cx-(r*cell)/2
            ytop=baseY-(rows-r+1)*cell
            for c in range(r):
                s.append(f'<rect x="{startx+c*cell:.0f}" y="{ytop}" width="{cell}" height="{cell}" fill="{fill}" stroke="#000"/>')
    s.append('<text x="375" y="150" font-size="26">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16=_pyr()

# ---- Úlohy ----

B = ['zs2', 'r7']  # 7. ročník, šestileté obory

PROBLEMS = [
    {'name':'CERMAT M7A 2022 – úloha 1','zad':[
        'Vypočtěte, kolik milimetrů jsou $\\frac{3}{20}$ ze tří metrů.'],
     'opts':None,'ln':2,
     'sol':['Tři metry jsou $3000$ mm. $\\frac{3}{20}$ ze $3000$ mm $=\\frac{3\\cdot 3000}{20}=450$ mm.'],
     'ans':'$450$ mm','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 2','zad':[
        'Na číselné ose je zobrazeno jedenáct bodů oddělujících deset stejných dílků. Body $A$, $B$, $C$, $D$ představují čtyři čísla. V bodě $C$ je číslo $48$. Číslo v bodě $D$ je o $24$ větší než číslo v bodě $B$.',
        '2.1 Vyznačte na číselné ose bod $P$, v němž je číslo $0$.',
        '2.2 Vypočtěte číslo v bodě $A$.'],
     'opts':None,'ln':0,'svg':SVG2,'fn':'ciselna-osa.svg',
     'alt':'Číselná osa s jedenácti dělicími body; body A, B, C, D označují čtyři čísla, nad bodem C je číslo 48.',
     'cap':'Číselná osa k úloze 2',
     'sol':['Mezi body $B$ a $D$ leží tři dílky a čísla se liší o $24$, takže jeden dílek odpovídá číslu $24:3=8$.',
            '2.1 Číslo $0$ je dva dílky vpravo od bodu $A$ (čtvrtý dělicí bod zleva).',
            '2.2 Bod $A$ je osm dílků vlevo od bodu $C$: $A=48-8\\cdot 8=-16$.'],
     'ans':'2.1: bod $P$ (číslo $0$) leží dva dílky vpravo od bodu $A$; 2.2: $A=-16$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\frac{2}{5}:\\frac{8}{15}-\\frac{7}{8}=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{2}{5}:\\frac{8}{15}=\\frac{2}{5}\\cdot\\frac{15}{8}=\\frac{30}{40}=\\frac{3}{4}$. Pak $\\frac{3}{4}-\\frac{7}{8}=\\frac{6}{8}-\\frac{7}{8}=-\\frac{1}{8}$.'],
     'ans':'$-\\frac{1}{8}$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\dfrac{\\frac{9}{7}\\cdot\\frac{14}{15}}{\\left(\\frac{4}{3}+2\\right)\\cdot 3}=$'],
     'opts':None,'ln':3,
     'sol':['Čitatel: $\\frac{9}{7}\\cdot\\frac{14}{15}=\\frac{126}{105}=\\frac{6}{5}$. Jmenovatel: $\\left(\\frac{4}{3}+2\\right)\\cdot 3=\\frac{10}{3}\\cdot 3=10$. Celkem $\\frac{6}{5}:10=\\frac{6}{50}=\\frac{3}{25}$.'],
     'ans':'$\\frac{3}{25}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 4.1','zad':[
        'Když neznámé kladné číslo vynásobíme samo sebou, dostaneme číslo o $17$ menší než devítinásobek čísla $9$.',
        'Určete neznámé číslo.'],
     'opts':None,'ln':3,
     'sol':['Devítinásobek čísla $9$ je $9\\cdot 9=81$. Hledané kladné číslo $x$ splňuje $x^2=81-17=64$, tedy $x=8$.'],
     'ans':'$8$','pts':2,'mins':3,'diff':'2',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 4.2','zad':[
        'V každé lahvi je dva a čtvrt litru sirupu. Ve všech lahvích je celkem $72$ litrů sirupu.',
        'Určete počet lahví se sirupem.'],
     'opts':None,'ln':2,
     'sol':['Jedna lahev obsahuje $2\\frac{1}{4}$ litru $=2{,}25$ litru. Počet lahví $=72:2{,}25=32$.'],
     'ans':'$32$ lahví','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2022 – úloha 5','zad':[
        'Letadlo letělo nad oceánem stálou rychlostí a za každou půlhodinu uletělo vzdálenost $360$ km.',
        '5.1 Vypočtěte, kolik kilometrů uletělo letadlo nad oceánem za $20$ minut.',
        '5.2 Vypočtěte, za jak dlouho uletělo letadlo nad oceánem vzdálenost $9\\,000$ km. Výsledek uveďte v hodinách a minutách.'],
     'opts':None,'ln':2,
     'sol':['Rychlost: $360$ km za $30$ minut, tj. $12$ km za minutu.',
            '5.1 Za $20$ minut: $12\\cdot 20=240$ km.',
            '5.2 $9\\,000:12=750$ minut $=12$ hodin $30$ minut.'],
     'ans':'5.1: $240$ km; 5.2: za $12$ hodin $30$ minut','pts':4,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2022 – úloha 6','zad':[
        'Petr šel stálou rychlostí z domova do sportovní haly. Když byl ve třetině cesty od domova, jeho hodinky ukazovaly čas $15{:}28$. Když mu k hale zbývala ještě čtvrtina cesty, ukazovaly hodinky čas $15{:}43$.',
        '6.1 Vypočtěte, kolik minut trvala Petrovi cesta z domova do sportovní haly.',
        '6.2 Vypočtěte, jaký čas ukazovaly Petrovy hodinky, když došel do sportovní haly.',
        '6.3 Vypočtěte, jaký čas ukazovaly Petrovy hodinky, když vycházel z domova.'],
     'opts':None,'ln':4,'svg':SVG6,'fn':'petr-cesta.svg',
     'alt':'Schematická křivka cesty z domova do haly se dvěma vyznačenými časy 15:28 a 15:43.',
     'cap':'Cesta Petra z domova do haly',
     'sol':['Mezi třetinou a třemi čtvrtinami cesty leží $\\frac{3}{4}-\\frac{1}{3}=\\frac{5}{12}$ cesty, což trvalo $15$ minut. Celá cesta tedy trvala $15\\cdot\\frac{12}{5}=36$ minut.',
            '6.2 Od tří čtvrtin cesty do cíle zbývá $\\frac{1}{4}$ cesty, tj. $36:4=9$ minut; $15{:}43+9$ min $=15{:}52$.',
            '6.3 První třetina cesty trvá $36:3=12$ minut; $15{:}28-12$ min $=15{:}16$.'],
     'ans':'6.1: $36$ minut; 6.2: $15{:}52$; 6.3: $15{:}16$','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2022 – úloha 7','zad':[
        'Graf udává počet nehod, k nimž došlo v obcích $A$, $B$, $C$ v jednotlivých čtvrtletích loňského roku, a celoroční počet nehod v obci $D$.',
        '7.1 Určete celkový počet nehod, k nimž došlo ve 3. čtvrtletí v obcích $A$, $B$ a $C$.',
        '7.2 Vyjádřete zlomkem, jakou část celoročního počtu nehod v obci $C$ tvoří nehody, k nimž v této obci došlo v 1. čtvrtletí.',
        '7.3 Určete, o kolik procent byl celoroční počet nehod v obci $A$ větší než celoroční počet nehod v obci $B$.',
        '7.4 V obci $D$ byly počty nehod v 1., 2. a 3. čtvrtletí v poměru $1:2:1$ a ve 4. čtvrtletí již k žádné dopravní nehodě nedošlo. Určete počet nehod ve 3. čtvrtletí v obci $D$.'],
     'opts':None,'ln':4,'svg':SVG7,'fn':'graf-nehody.svg',
     'alt':'Skládaný sloupcový graf počtu nehod v obcích A, B, C podle čtvrtletí a celoroční sloupec obce D.',
     'cap':'Počet nehod v obcích podle čtvrtletí',
     'sol':['7.1 Ve 3. čtvrtletí: obec $A$ $6$, obec $B$ $4$, obec $C$ $8$ nehod, celkem $18$ nehod.',
            '7.2 Obec $C$ má celkem $26$ nehod, v 1. čtvrtletí $10$: $\\frac{10}{26}=\\frac{5}{13}$.',
            '7.3 Obec $A$ má $20$, obec $B$ $16$ nehod: $\\frac{20-16}{16}=0{,}25$, tj. o $25\\,\\%$.',
            '7.4 Poměr $1:2:1$ dává $4$ díly $=24$ nehod, jeden díl $=6$; ve 3. čtvrtletí je $1$ díl, tj. $6$ nehod.'],
     'ans':'7.1: $18$ nehod; 7.2: $\\frac{5}{13}$; 7.3: o $25\\,\\%$; 7.4: $6$ nehod','pts':4,'mins':7,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2022 – úloha 8 (konstrukce)','zad':[
        'V rovině leží body $A$, $D$, $R$ (viz obrázek).',
        'Body $A$, $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$ s pravým úhlem při vrcholu $D$. Základna $AB$ a rameno $AD$ tohoto lichoběžníku mají stejnou délku. Bod $R$ leží na rameni $BC$ lichoběžníku $ABCD$.',
        'Sestrojte vrcholy $B$, $C$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'body-ADR.svg',
     'alt':'Tři body A, D, R v rovině.','cap':'Výchozí obrázek k úloze 8',
     'sol':['Lichoběžník $ABCD$ je pravoúhlý s pravým úhlem u $D$ (a u $A$), takže rameno $AD$ je kolmé na obě základny. Ve vrcholu $A$ vztyčíme kolmici k $AD$ a naneseme $|AB|=|AD|$ (bod $B$). Základna $DC$ je kolmice k $AD$ v bodě $D$ (rovnoběžka s $AB$). Vrchol $C$ leží na této rovnoběžce a zároveň na přímce $BR$, protože bod $R$ je na rameni $BC$.'],
     'ans':'Konstrukce pravoúhlého lichoběžníku $ABCD$: pravý úhel u $A$ i $D$, $|AB|=|AD|$, základna $DC$ rovnoběžná s $AB$, vrchol $C$ na přímce $BR$ ($R$ na rameni $BC$) – viz obrázek v klíči.',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 9 (konstrukce)','zad':[
        'V rovině leží body $P$, $S$ a přímka $q$ (viz obrázek).',
        'Bod $P$ je vrchol trojúhelníku $PQR$. Na přímce $q$ leží vrchol $Q$ tohoto trojúhelníku. Vrcholy $P$ a $Q$ mají od bodu $S$ stejnou vzdálenost. Bod $S$ je zároveň středem strany $QR$.',
        'Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-PSq.svg',
     'alt':'Body P a S a přímka q v rovině.','cap':'Výchozí obrázek k úloze 9',
     'sol':['Protože $|SP|=|SQ|$ a bod $S$ je střed $QR$ (tedy $|SQ|=|SR|$), leží body $P$, $Q$, $R$ na kružnici se středem $S$ a poloměrem $|SP|$. Vrchol $Q$ je průsečík této kružnice s přímkou $q$ (dvě polohy $Q_1$, $Q_2$); vrchol $R$ je obraz bodu $Q$ ve středové souměrnosti podle bodu $S$. Úloha má dvě řešení.'],
     'ans':'Dvě řešení: kružnice se středem $S$ a poloměrem $|SP|$ protne přímku $q$ v bodech $Q_1$, $Q_2$; bod $R$ je souměrný s $Q$ podle středu $S$ (trojúhelníky $PQ_1R_1$, $PQ_2R_2$) – viz obrázek v klíči.',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 10','zad':[
        'V rovině jsou zakresleny tři útvary (viz obrázek).',
        'Rozhodněte o každém z útvarů (10.1–10.3), zda je osově souměrný (Ano), či nikoli (Ne).',
        '10.1 1. útvar',
        '10.2 2. útvar',
        '10.3 3. útvar'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'utvary.svg',
     'alt':'Tři nepravidelné útvary složené z pravoúhlých částí – schematické znázornění.',
     'cap':'Tři útvary (schematicky – posuzujte podle originálu)',
     'sol':['10.1 První útvar je osově souměrný – Ano.',
            '10.2 Druhý útvar není osově souměrný – Ne.',
            '10.3 Třetí útvar není osově souměrný – Ne.'],
     'ans':'10.1: Ano; 10.2: Ne; 10.3: Ne','pts':4,'mins':5,'diff':'3',
     'codes':B+['planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 11','zad':[
        'V rovině leží dva rovnoramenné trojúhelníky, které mají jednu stranu společnou. Velikosti úhlů neměřte, ale vypočtěte (viz obrázek).',
        'Jaká je velikost úhlu $\\beta$?'],
     'opts':['A) menší než $120^\\circ$','B) $120^\\circ$','C) $130^\\circ$','D) $140^\\circ$','E) větší než $140^\\circ$'],'ln':0,
     'svg':SVG11,'fn':'trojuhelniky-uhel.svg',
     'alt':'Dva rovnoramenné trojúhelníky se společnou stranou; vyznačené úhly α, β, 5α a dva úhly 40 stupňů.',
     'cap':'Dva rovnoramenné trojúhelníky se společnou stranou',
     'sol':['Dolní trojúhelník je rovnoramenný se základními úhly $40^\\circ$; jeho úhel při společném vrcholu je $5\\alpha=180^\\circ-2\\cdot 40^\\circ=100^\\circ$, takže $\\alpha=20^\\circ$. Horní trojúhelník je rovnoramenný se základními úhly $\\alpha=20^\\circ$, proto $\\beta=180^\\circ-2\\cdot 20^\\circ=140^\\circ$.'],
     'ans':'D) $140^\\circ$','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 12','zad':[
        'Podstavou kolmého trojbokého hranolu $ABCDEF$ s výškou $10$ cm je rovnoramenný trojúhelník $ABC$, jehož obsah je $12$ cm², obvod je $16$ cm a délka základny $AB$ je $6$ cm (viz obrázek).',
        'Jaký je objem hranolu $ABCDEF$?'],
     'opts':['A) $120$ cm³','B) $125$ cm³','C) $180$ cm³','D) $240$ cm³','E) jiný objem'],'ln':0,
     'svg':SVG12,'fn':'hranol.svg',
     'alt':'Kolmý trojboký hranol ABCDEF s dolní podstavou ABC a horní podstavou DEF.',
     'cap':'Kolmý trojboký hranol ABCDEF',
     'sol':['Objem $=$ obsah podstavy $\\times$ výška $=12\\cdot 10=120$ cm³.'],
     'ans':'A) $120$ cm³','pts':2,'mins':3,'diff':'2',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 13','zad':[
        'Podstavou kolmého trojbokého hranolu $ABCDEF$ s výškou $10$ cm je rovnoramenný trojúhelník $ABC$, jehož obsah je $12$ cm², obvod je $16$ cm a délka základny $AB$ je $6$ cm (viz obrázek).',
        'Jaký je povrch hranolu $ABCDEF$?'],
     'opts':['A) $160$ cm²','B) $184$ cm²','C) $190$ cm²','D) $204$ cm²','E) jiný povrch'],'ln':0,
     'svg':SVG12,'fn':'hranol13.svg',
     'alt':'Kolmý trojboký hranol ABCDEF s dolní podstavou ABC a horní podstavou DEF.',
     'cap':'Kolmý trojboký hranol ABCDEF',
     'sol':['Povrch $=$ dvě podstavy $+$ plášť $=2\\cdot 12+16\\cdot 10=24+160=184$ cm².'],
     'ans':'B) $184$ cm²','pts':2,'mins':4,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 14','zad':[
        'Na Dračí horu přiletěli dvouhlaví a tříhlaví draci. Dohromady měli $115$ hlav. Dvouhlavých draků přiletělo o $35$ více než tříhlavých.',
        'Kolik draků přiletělo na Dračí horu?'],
     'opts':['A) $53$ draků','B) $50$ draků','C) $45$ draků','D) $40$ draků','E) jiný počet draků'],'ln':0,
     'sol':['Označme počet tříhlavých draků $t$, dvouhlavých $t+35$. Pro počet hlav platí $3t+2(t+35)=115$, tj. $5t+70=115$, $t=9$. Dvouhlavých je $44$, celkem $9+44=53$ draků.'],
     'ans':'A) $53$ draků','pts':2,'mins':4,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2022 – úloha 15','zad':[
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Kniha se původně prodávala za $300$ korun. Po zlevnění stojí jen $40\\,\\%$ původní ceny. O kolik korun byla kniha zlevněna?',
        '15.2 Původní cena knihy byla snížena o $120$ korun. Po tomto zlevnění se tak prodávala za $25\\,\\%$ původní ceny. Jaká byla původní cena knihy?',
        '15.3 Kniha byla zlevněna dvakrát. Na léto byla zlevněna o $50$ korun, tj. o $20\\,\\%$ původní ceny. Na podzim pak byla zlevněna ještě o čtvrtinu letní ceny. Kolik korun stála kniha po obou slevách?'],
     'opts':['A) méně než $120$ korun','B) $120$ korun','C) $150$ korun','D) $160$ korun','E) $180$ korun','F) více než $180$ korun'],'ln':0,
     'sol':['15.1 Po zlevnění stojí $40\\,\\%$ ze $300=120$ korun; zlevněna byla o $300-120=180$ korun → E.',
            '15.2 Původní cena $x$: $x-120=0{,}25x$, tj. $0{,}75x=120$, $x=160$ korun → D.',
            '15.3 $50$ korun je $20\\,\\%$ původní ceny, tedy původní cena $250$ korun; letní cena $250-50=200$ korun; podzimní cena $200-\\frac{1}{4}\\cdot 200=150$ korun → C.'],
     'ans':'15.1: E ($180$ korun); 15.2: D ($160$ korun); 15.3: C ($150$ korun)','pts':6,'mins':8,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7A 2022 – úloha 16','zad':[
        'Pyramida se skládá ze shodných čtverců. Horní řadu tvoří vždy jeden tmavý čtverec. V pyramidě, která má více než $1$ čtverec, se pravidelně střídají řady s tmavými a řady s bílými čtverci. Každá další řada má vždy o $1$ čtverec více než řada nad ní (viz obrázek).',
        '16.1 Pyramida má $10$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.',
        '16.2 Pyramida má $73$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.',
        '16.3 V pyramidě je o $101$ bílých čtverců méně než tmavých čtverců. Určete, kolik řad má pyramida.'],
     'opts':None,'ln':4,'svg':SVG16,'fn':'pyramida.svg',
     'alt':'Pyramidy z 1, 2, 3 a 4 řad se střídajícími se tmavými a bílými řadami čtverců.',
     'cap':'Pyramidy z 1, 2, 3 a 4 řad',
     'sol':['Řada $k$ má $k$ čtverců; liché řady jsou tmavé, sudé bílé.',
            '16.1 Tmavé (řady 1,3,5,7,9): $1+3+5+7+9=25$; bílé (2,4,6,8,10): $2+4+6+8+10=30$. Liší se o $30-25=5$ čtverce.',
            '16.2 Tmavé $1+3+\\dots+73=37^2=1369$; bílé $2+4+\\dots+72=36\\cdot 37=1332$. Liší se o $1369-1332=37$ čtverců.',
            '16.3 Pro lichý počet řad $2m+1$ je tmavých o $m+1$ více než bílých: $m+1=101$, $m=100$, tedy $2m+1=201$ řad.'],
     'ans':'16.1: o $5$ čtverců; 16.2: o $37$ čtverců; 16.3: $201$ řad','pts':4,'mins':8,'diff':'3',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD22C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
