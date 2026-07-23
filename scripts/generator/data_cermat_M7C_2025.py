# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2025, MATEMATIKA 7C (šestileté obory, 7. ročník),
# 1. náhradní termín. Kód testu: M7PCD25C0T03. 16 úloh, 50 bodů
# (po rozdělení izolovaných poduúloh 18 úloh).
# Zdroj odpovědí: klíč správných řešení (rozšířený klíč, KSR).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: šestiúhelník rozdělený dvěma úhlopříčkami na dva bílé čtverce
# (malý 9 cm, velký 12 cm) a dva shodné tmavé pravoúhlé trojúhelníky (odvěsny 9 a 12)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 235 235" font-family="sans-serif">
<polygon points="10,130 100,130 100,10" fill="#b0b0b0" stroke="#000"/>
<polygon points="100,130 220,130 100,220" fill="#b0b0b0" stroke="#000"/>
<rect x="100" y="10" width="120" height="120" fill="#ffffff" stroke="#000"/>
<rect x="10" y="130" width="90" height="90" fill="#ffffff" stroke="#000"/>
<polygon points="10,130 100,10 220,10 220,130 100,220 10,220" fill="none" stroke="#000" stroke-width="2"/>
<line x1="100" y1="10" x2="100" y2="220" stroke="#000"/>
<line x1="10" y1="130" x2="220" y2="130" stroke="#000"/>
<text x="160" y="74" font-size="11" text-anchor="middle">velký</text>
<text x="55" y="178" font-size="11" text-anchor="middle">malý</text>
</svg>"""

# úloha 8: body B, M a přímka q (výchozí obrázek ke konstrukci)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<rect x="6" y="6" width="448" height="308" fill="none" stroke="#cccccc"/>
<line x1="70" y1="185" x2="400" y2="185" stroke="#000" stroke-width="2"/>
<text x="408" y="190" font-size="15" font-style="italic">q</text>
<text x="231" y="122" font-size="14">×</text><text x="230" y="140" font-size="15" font-style="italic">M</text>
<text x="251" y="260" font-size="14">×</text><text x="250" y="278" font-size="15" font-style="italic">B</text>
</svg>"""

# úloha 9: body A, D, M (výchozí obrázek ke konstrukci)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<rect x="6" y="6" width="448" height="308" fill="none" stroke="#cccccc"/>
<text x="298" y="122" font-size="14">×</text><text x="297" y="140" font-size="15" font-style="italic">M</text>
<text x="151" y="206" font-size="14">×</text><text x="150" y="224" font-size="15" font-style="italic">D</text>
<text x="246" y="222" font-size="14">×</text><text x="245" y="240" font-size="15" font-style="italic">A</text>
</svg>"""

# úloha 10: skupinový sloupcový graf – prodané vstupenky (Děti, Dospělí) po měsících
def _bars10():
    data = [('Květen',30,80),('Červen',10,60),('Červenec',30,70),('Srpen',50,90),('Září',40,100)]
    x0, y0 = 62, 260; sc = 2.0; bw = 20; gap = 62
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 300" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="450" y2="{y0}" stroke="#000"/>')
    for v in range(0, 111, 10):
        y = y0 - v*sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="10" text-anchor="end">{v}</text>')
    x = x0 + 22
    for name, d, a in data:
        hd = d*sc; ha = a*sc
        s.append(f'<rect x="{x}" y="{y0-hd}" width="{bw}" height="{hd}" fill="#555" stroke="#000"/>')
        s.append(f'<rect x="{x+bw}" y="{y0-ha}" width="{bw}" height="{ha}" fill="#dddddd" stroke="#000"/>')
        s.append(f'<text x="{x+bw}" y="{y0+14}" font-size="10" text-anchor="middle">{name}</text>')
        x += gap
    s.append('<rect x="378" y="42" width="12" height="12" fill="#555" stroke="#000"/><text x="396" y="52" font-size="11">Děti</text>')
    s.append('<rect x="378" y="60" width="12" height="12" fill="#dddddd" stroke="#000"/><text x="396" y="70" font-size="11">Dospělí</text>')
    s.append('<text x="18" y="150" font-size="10" text-anchor="middle" transform="rotate(-90 18 150)">Počet prodaných vstupenek</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _bars10()

# úloha 13: krychle s šedými čtverci na úhlopříčkách stěn (schematicky – přední stěna)
def _cube():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 320" font-family="sans-serif">']
    s.append('<rect x="60" y="120" width="180" height="180" fill="#ffffff" stroke="#000" stroke-width="2"/>')
    s.append('<polygon points="60,120 120,60 300,60 240,120" fill="#ffffff" stroke="#000" stroke-width="2"/>')
    s.append('<polygon points="240,120 300,60 300,240 240,300" fill="#ffffff" stroke="#000" stroke-width="2"/>')
    for i in range(5):
        x = 60 + i*36; y = 264 - i*36
        s.append(f'<rect x="{x}" y="{y}" width="36" height="36" fill="#b0b0b0" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _cube()

# úloha 14: obdélník ABCD, bod X na CD, osy úhlů o1, o2, vyznačené úhly 22°, 62°, alfa
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 370" font-family="sans-serif">
<rect x="60" y="60" width="360" height="240" fill="none" stroke="#000" stroke-width="2"/>
<text x="50" y="54" font-size="15" font-weight="bold">D</text>
<text x="424" y="54" font-size="15" font-weight="bold">C</text>
<text x="46" y="318" font-size="15" font-weight="bold">A</text>
<text x="424" y="318" font-size="15" font-weight="bold">B</text>
<text x="278" y="52" font-size="15" font-weight="bold">X</text>
<line x1="285" y1="60" x2="60" y2="300" stroke="#000" stroke-width="2"/>
<line x1="285" y1="60" x2="420" y2="300" stroke="#000" stroke-width="2"/>
<line x1="40" y1="316" x2="482" y2="176" stroke="#000" stroke-dasharray="7 3 2 3"/>
<text x="486" y="176" font-size="14" font-style="italic">o1</text>
<line x1="285" y1="60" x2="250" y2="342" stroke="#000" stroke-dasharray="7 3 2 3"/>
<text x="238" y="356" font-size="14" font-style="italic">o2</text>
<text x="96" y="292" font-size="13">22°</text>
<text x="250" y="188" font-size="13">62°</text>
<text x="392" y="286" font-size="14" font-style="italic">α</text>
</svg>"""

# úloha 16: obrazce z bílých a šedých rovnostranných trojúhelníků (schematicky, 1.-3. obrazec)
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 240" font-family="sans-serif">
<text x="80" y="36" font-size="12" text-anchor="middle">1. obrazec</text>
<text x="230" y="36" font-size="12" text-anchor="middle">2. obrazec</text>
<text x="360" y="36" font-size="12" text-anchor="middle">3. obrazec</text>
<polygon points="80,140 110,140 95,114" fill="#b0b0b0" stroke="#000"/>
<polygon points="80,140 95,114 65,114" fill="#ffffff" stroke="#000"/>
<polygon points="80,140 65,114 50,140" fill="#b0b0b0" stroke="#000"/>
<polygon points="80,140 50,140 65,166" fill="#ffffff" stroke="#000"/>
<polygon points="80,140 65,166 95,166" fill="#b0b0b0" stroke="#000"/>
<polygon points="80,140 95,166 110,140" fill="#ffffff" stroke="#000"/>
<polygon points="290,140 260,192 200,192 170,140 200,88 260,88" fill="#e8e8e8" stroke="#000"/>
<polygon points="450,140 405,218 315,218 270,140 315,62 405,62" fill="#e8e8e8" stroke="#000"/>
<text x="480" y="148" font-size="20">…</text>
</svg>"""

B = ['zs2', 'r7']  # 7. ročník ZŠ / šestileté obory (2. stupeň), ročník r7

PROBLEMS = [
    {'name':'CERMAT M7C 2025 – úloha 1','zad':[
        'Vlak vyjel v poledne ze stanice a za každých 8 minut ujel 7 km. Ve 12:20 vlak minul lom a ve 12:36 dojel na most přes řeku.',
        'Určete v km vzdálenost, kterou ujel vlak od lomu k mostu.'],
     'opts':None,'ln':2,
     'sol':['Od 12:20 do 12:36 uplynulo $16$ minut, což je dvakrát $8$ minut. Vlak tedy ujel $2\\cdot 7=14$ km.'],
     'ans':'$14$ km','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 2.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{1}{4}+\\left(\\frac{9}{10}-\\frac{3}{5}\\right)-\\left(1-\\frac{1}{6}\\right):\\frac{5}{3}=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{9}{10}-\\frac{3}{5}=\\frac{3}{10}$, $\\left(1-\\frac{1}{6}\\right):\\frac{5}{3}=\\frac{5}{6}\\cdot\\frac{3}{5}=\\frac{1}{2}$. Pak $\\frac{1}{4}+\\frac{3}{10}-\\frac{1}{2}=\\frac{5}{20}+\\frac{6}{20}-\\frac{10}{20}=\\frac{1}{20}$.'],
     'ans':'$\\frac{1}{20}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 2.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{3}{5}\\cdot\\frac{3}{5}}{\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{9}{5}\\right)}=$'],
     'opts':None,'ln':3,
     'sol':['Čitatel $\\frac{3}{5}\\cdot\\frac{3}{5}=\\frac{9}{25}$. Jmenovatel $\\frac{2}{3}-\\frac{9}{5}=-\\frac{17}{15}$, $\\frac{27}{34}\\cdot\\left(-\\frac{17}{15}\\right)=-\\frac{9}{10}$. Podíl $\\frac{9}{25}:\\left(-\\frac{9}{10}\\right)=\\frac{9}{25}\\cdot\\left(-\\frac{10}{9}\\right)=-\\frac{2}{5}$.'],
     'ans':'$-\\frac{2}{5}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 3','zad':[
        'Stuhu jsme beze zbytku rozstříhali na 20 dílů dvou různých délek – kratší díly po 20 cm a delší po 30 cm. Kratších dílů bylo o třetinu méně než delších dílů.',
        '3.1 Vypočtěte, kolik delších dílů jsme ze stuhy nastříhali.',
        '3.2 Vypočtěte, kolik cm měřila celá stuha, než jsme ji začali stříhat.'],
     'opts':None,'ln':2,
     'sol':['3.1 Kratších je o třetinu méně, tj. $\\frac{2}{3}$ počtu delších. Označíme delší $d$: $d+\\frac{2}{3}d=20$, tedy $\\frac{5}{3}d=20$, $d=12$. Delších dílů je $12$, kratších $8$.',
            '3.2 Celá stuha měřila $8\\cdot 20+12\\cdot 30=160+360=520$ cm.'],
     'ans':'3.1: $12$ delších dílů; 3.2: $520$ cm','pts':2,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 4','zad':[
        'Adam pravidelně kupuje pro psy mražené mleté maso v baleních po 1,5 kg. Dnes měl v peněžence o 14 korun víc, než potřeboval minule na nákup 9 kg masa. Maso však bylo zdraženo, a tak mu dnes na nákup stejného množství masa 40 korun chybělo. Koupil proto o 1 balení masa méně a v peněžence mu zbylo 50 korun.',
        '4.1 Vypočtěte, kolik balení masa Adam dnes koupil.',
        '4.2 Vypočtěte, kolik korun dnes stálo jedno balení masa.',
        '4.3 Vypočtěte, kolik korun si dnes Adam vzal na nákup masa.',
        '4.4 Vypočtěte, o kolik korun bylo dnes jedno balení masa dražší než minule.'],
     'opts':None,'ln':4,
     'sol':['$9$ kg $=6$ balení po $1{,}5$ kg. Označíme dnešní cenu balení $c$ a částku v peněžence $P$. Na $6$ balení dnes chybělo $40$ Kč: $6c=P+40$. Koupil $5$ balení a zbylo $50$ Kč: $P-5c=50$, tj. $P=50+5c$.',
            '4.1 Koupil o $1$ balení méně než $6$, tedy $5$ balení.',
            '4.2 Z $6c=50+5c+40$ plyne $c=90$ Kč.',
            '4.3 $P=50+5\\cdot 90=500$ Kč.',
            '4.4 Minule na $6$ balení potřeboval $P-14=486$ Kč, tj. $486:6=81$ Kč za balení. Rozdíl $90-81=9$ Kč.'],
     'ans':'4.1: $5$ balení; 4.2: $90$ korun; 4.3: $500$ korun; 4.4: o $9$ korun','pts':4,'mins':7,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7C 2025 – úloha 5','zad':[
        'Cyklista jel část své trasy po rovině, část klesal a zbytek trasy stoupal. Po rovině ujel třetinu délky celé trasy, klesání bylo pětkrát kratší než celá trasa. Stoupání bylo na 14 km trasy a cyklista v něm za každou minutu ujel 280 m.',
        '5.1 Vypočtěte v km délku celé cyklistovy trasy.',
        '5.2 Vypočtěte, kolik minut cyklista na své trase stoupal.'],
     'opts':None,'ln':2,
     'sol':['5.1 Rovina je $\\frac{1}{3}$ trasy, klesání $\\frac{1}{5}$ trasy, stoupání $14$ km. Pro délku $c$ platí $c-\\frac{c}{3}-\\frac{c}{5}=14$, tj. $\\frac{7}{15}c=14$, $c=30$ km.',
            '5.2 Ve stoupání jel $280$ m za minutu, tj. $0{,}28$ km/min. $14:0{,}28=50$ minut.'],
     'ans':'5.1: $30$ km; 5.2: $50$ minut','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 6.1','zad':[
        'Písmena $K$, $L$ představují dvě různé číslice. V zápise součtu dvou trojciferných čísel $KLL+KLK$ se místo hvězdiček doplní chybějící číslice součtu tak, aby byl výpočet správný; součet má tvar $\\ast\\,\\ast\\,1\\,1$ (končí dvojčíslím $11$).',
        'Určete číslice, kterými se nahradí písmena $K$, $L$, a zapište je v tomto pořadí.'],
     'opts':None,'ln':3,
     'sol':['Součet je čtyřciferný a končí $11$. Z jednotek $L+K$ končí $1$; ze součtu $KLL+KLK=1311$ (pro $K=6$, $L=5$: $655+656=1311$) vychází $K=6$, $L=5$.'],
     'ans':'$K=6$, $L=5$','pts':1,'mins':4,'diff':'3',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 6.2','zad':[
        'Písmena $S$, $T$, $U$ představují tři navzájem různé číslice. V zápise součtu tří dvouciferných čísel $ST+ST+TU=211$ se písmena nahradí číslicemi tak, aby byl výpočet správný.',
        'Určete číslice, kterými se nahradí písmena $S$, $T$, $U$, a zapište je v tomto pořadí. Najděte všechna tři řešení.'],
     'opts':None,'ln':4,
     'sol':['Platí $2(10S+T)+(10T+U)=211$, tj. $20S+12T+U=211$. Tři řešení s navzájem různými číslicemi: $S,T,U=9,2,7$ ($92+92+27$); $8,4,3$ ($84+84+43$); $5,9,3$ ($59+59+93$).'],
     'ans':'$S,T,U$: $9,2,7$; $8,4,3$; $5,9,3$','pts':3,'mins':6,'diff':'4',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 7','zad':[
        'Šestiúhelník na obrázku je rozdělen dvěma úhlopříčkami na dva bílé čtverce a dva shodné tmavé trojúhelníky. Poměr délek stran velkého a malého čtverce je $4:3$ a obvody obou čtverců se liší o 12 cm. Obvod jednoho tmavého trojúhelníku je stejný jako obvod malého čtverce.',
        '7.1 Vypočtěte v cm délku strany malého čtverce.',
        '7.2 Vypočtěte v cm² obsah šestiúhelníku.',
        '7.3 Určete, kolikrát větší je obvod šestiúhelníku než obvod malého čtverce.'],
     'opts':None,'ln':3,'svg':SVG7,'fn':'sestiuhelnik.svg',
     'alt':'Šestiúhelník rozdělený dvěma úhlopříčkami na malý a velký bílý čtverec a dva shodné tmavé pravoúhlé trojúhelníky.',
     'cap':'Schematický nákres (poměr stran 4:3)',
     'sol':['7.1 Strany v poměru $4:3$, tj. $4k$ a $3k$. Rozdíl obvodů $4\\cdot 4k-4\\cdot 3k=4k=12$, tedy $k=3$. Malý čtverec má stranu $3k=9$ cm (velký $12$ cm).',
            '7.2 Tmavý trojúhelník je pravoúhlý s odvěsnami $9$ a $12$ (obvod $9+12+15=36$ cm $=$ obvod malého čtverce), obsah $\\frac{1}{2}\\cdot 9\\cdot 12=54$ cm². Obsah šestiúhelníku $=12^2+9^2+2\\cdot 54=144+81+108=333$ cm².',
            '7.3 Obvod šestiúhelníku $=12+12+15+15+9+9=72$ cm; obvod malého čtverce $=36$ cm. Poměr $72:36=2$, tedy 2krát.'],
     'ans':'7.1: $9$ cm; 7.2: $333$ cm²; 7.3: 2krát','pts':4,'mins':7,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 8 (konstrukce)','zad':[
        'V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).',
        'Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek tohoto trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$ trojúhelníku $ABC$.',
        'Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'body-BM-q.svg',
     'alt':'Body B a M a vodorovná přímka q v rovině.','cap':'Výchozí obrázek k úloze 8',
     'sol':['Protože $BM$ je výška na stranu $AC$, je úhel $BMA$ pravý. Vrchol $A$ tedy leží na kolmici k přímce $BM$ vedené bodem $M$ a zároveň na přímce $q$; $A$ je jejich průsečík. Strana $AC$ leží na přímce $AM$. Trojúhelník je rovnoramenný se základnou $AB$, proto vrchol $C$ leží na ose úsečky $AB$; $C$ je průsečík přímky $AM$ s osou úsečky $AB$.'],
     'ans':'Konstrukce: $A$ = průsečík přímky $q$ s kolmicí k $BM$ v bodě $M$; $C$ = průsečík přímky $AM$ s osou úsečky $AB$ (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 9 (konstrukce)','zad':[
        'V rovině leží body $A$, $D$, $M$ (viz obrázek).',
        'Body $A$, $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$. Na polopřímce $DM$ leží vrchol $B$ tohoto lichoběžníku. Přitom délka strany $AB$ je stejná jako délka úsečky $DM$.',
        'Sestrojte vrcholy $B$, $C$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-ADM.svg',
     'alt':'Body A, D a M v rovině.','cap':'Výchozí obrázek k úloze 9',
     'sol':['Vrchol $B$ leží na polopřímce $DM$ a platí $|AB|=|DM|$; sestrojíme jej jako průsečík polopřímky $DM$ s kružnicí se středem $A$ a poloměrem $|DM|$. Vrchol $C$ dopočteme tak, aby čtyřúhelník $ABCD$ byl pravoúhlý lichoběžník (dvě rovnoběžné strany a pravý úhel). Úloha má dvě řešení (vrcholy $C_1$, $C_2$).'],
     'ans':'Dvě řešení ($C_1$, $C_2$): $B$ na polopřímce $DM$ s $|AB|=|DM|$, $C$ doplní pravoúhlý lichoběžník $ABCD$ (viz obrázek v klíči).',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 10','zad':[
        'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně (Květen: děti 30, dospělí 80; Červen: 10, 60; Červenec: 30, 70; Srpen: 50, 90; Září: 40, 100).',
        'Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.',
        '10.2 Za celou sezonu bylo dospělých návštěvníků rodného domu průměrně 80 za měsíc.',
        '10.3 Za celou sezonu tvořily děti 40 % všech návštěvníků rodného domu.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'graf-navstevnost.svg',
     'alt':'Skupinový sloupcový graf prodaných vstupenek pro děti a dospělé za měsíce květen až září.',
     'cap':'Prodané vstupenky v jednotlivých měsících',
     'sol':['10.1 První tři měsíce: děti $30+10+30=70$, dospělí $80+60+70=210=3\\cdot 70$. Pravda → Ano.',
            '10.2 Dospělí celkem $80+60+70+90+100=400$; průměr $400:5=80$. Pravda → Ano.',
            '10.3 Děti celkem $160$, dospělí $400$, všichni $560$; podíl dětí $\\frac{160}{560}\\approx 28{,}6\\,\\%$, ne $40\\,\\%$ → Ne.'],
     'ans':'10.1: Ano; 10.2: Ano; 10.3: Ne','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 11','zad':[
        'Počet všech žáků učiliště je větší než 150 a menší než 290. Když jsme rozdělili všechny žáky učiliště do skupin po 24 žácích, zbylo 5 žáků. Při rozdělení všech žáků do skupin po 36 opět zbylo 5 žáků.',
        'Kolik žáků je na učilišti?'],
     'opts':['A) méně než 170 žáků','B) alespoň 170, ale méně než 190 žáků','C) alespoň 190, ale méně než 220 žáků','D) alespoň 220, ale méně než 250 žáků','E) více než 250 žáků'],'ln':0,
     'sol':['Počet zmenšený o $5$ je dělitelný $24$ i $36$, tedy dělitelný jejich nejmenším společným násobkem $72$. Počet má tvar $72k+5$; v rozmezí $150$ až $290$ vyhovuje jen $72\\cdot 3+5=221$. To je „alespoň 220, ale méně než 250".'],
     'ans':'D) alespoň 220, ale méně než 250 žáků','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 12','zad':[
        'Ve městě bylo třeba vydláždit náměstí. Radní města chtěli původně najmout 6 dlaždičů, kteří by společně vydláždili celé náměstí za 30 dní. Náměstí však bylo třeba otevřít dříve, proto radní najali raději o 9 dlaždičů více. Celé náměstí pak vydláždili všichni najatí dlaždiči společně. Každý dlaždič vydláždí za den stejně velkou plochu.',
        'Za kolik dní bylo náměstí vydlážděno?'],
     'opts':['A) za 2 dny','B) za 10 dní','C) za 12 dní','D) za 18 dní','E) za 20 dní'],'ln':0,
     'sol':['Práce je $6\\cdot 30=180$ dlaždičodnů. Dlaždičů bylo $6+9=15$, náměstí tedy vydláždili za $180:15=12$ dní.'],
     'ans':'C) za 12 dní','pts':2,'mins':4,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 13','zad':[
        'Na každé stěně krychle je vždy jedna úhlopříčka celá přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých nepolepených ploch na povrchu krychle je 480 cm².',
        'Jakou délku má hrana krychle?'],
     'opts':['A) méně než 10 cm','B) 10 cm','C) 12 cm','D) 15 cm','E) 20 cm'],'ln':0,'svg':SVG13,'fn':'krychle.svg',
     'alt':'Krychle s pěti šedými čtverci nalepenými podél úhlopříčky každé stěny (schematicky, přední stěna).',
     'cap':'Schematický nákres (šedé čtverce na úhlopříčce stěny)',
     'sol':['Hrana $a$. Pět šedých čtverců podél úhlopříčky stěny má úhlopříčky $\\frac{a\\sqrt2}{5}$, tedy stranu $\\frac{a}{5}$ a obsah $\\frac{a^2}{25}$; na jedné stěně je jich pět, tj. šedá plocha $\\frac{a^2}{5}$. Bílá plocha jedné stěny je $a^2-\\frac{a^2}{5}=\\frac{4a^2}{5}$, na šesti stěnách $6\\cdot\\frac{4a^2}{5}=\\frac{24a^2}{5}=480$, odtud $a^2=100$, $a=10$ cm.'],
     'ans':'B) 10 cm','pts':2,'mins':5,'diff':'4',
     'codes':B+['stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 14','zad':[
        'V obdélníku $ABCD$ leží na straně $CD$ bod $X$. Přímka $o_1$ je osa úhlu $BAX$ a přímka $o_2$ je osa úhlu $AXB$. Velikosti některých úhlů jsou vyznačeny v obrázku (u vrcholu $A$ úhel $22^\\circ$, mezi osami $o_1$ a $o_2$ úhel $62^\\circ$).',
        'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).'],
     'opts':['A) $22^\\circ$','B) $28^\\circ$','C) $34^\\circ$','D) $40^\\circ$','E) jiná velikost'],'ln':0,'svg':SVG14,'fn':'obdelnik-osy.svg',
     'alt':'Obdélník ABCD s bodem X na straně CD, úsečkami XA a XB a osami úhlů o1, o2; vyznačené úhly 22°, 62° a alfa u vrcholu B.',
     'cap':'Schematický nákres (obrázek je ilustrativní)',
     'sol':['Osa $o_1$ dělí úhel $BAX$; $22^\\circ$ je jeho polovina, takže úhel $BAX=44^\\circ$. Úhel mezi osami $o_1$ a $o_2$ je vnějším úhlem trojúhelníku $A$, $X$, průsečík os, proto se rovná součtu polovin úhlů $BAX$ a $AXB$: $22^\\circ+\\frac{1}{2}\\cdot\\angle AXB=62^\\circ$, tedy $\\frac{1}{2}\\cdot\\angle AXB=40^\\circ$ a $\\angle AXB=80^\\circ$. V trojúhelníku $ABX$ je úhel $ABX=180^\\circ-44^\\circ-80^\\circ=56^\\circ$. Protože $\\angle ABC=90^\\circ$, je $\\alpha=\\angle XBC=90^\\circ-56^\\circ=34^\\circ$.'],
     'ans':'C) $34^\\circ$','pts':2,'mins':6,'diff':'4',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2025 – úloha 15','zad':[
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Prázdný kbelík se zcela naplní přesně 50 hrnky borůvek. Z plného kbelíku jsme odsypali 46 % borůvek. Kolik hrnků borůvek zbývá v kbelíku?',
        '15.2 Hrnčíři Petr, Radim, Slávek a Tomáš vyrobili dohromady 240 hrnků. Petr vyrobil o polovinu méně hrnků než Radim. Slávek i Tomáš vyrobili každý o 25 % hrnků méně než Radim. O kolik hrnků více vyrobil Tomáš než Petr?',
        '15.3 Jitka s maminkou a babičkou trhaly na zahradě rybíz do stejně velkých hrnků. Maminka natrhala dvakrát více rybízu než Jitka. Babička natrhala o polovinu více rybízu než Jitka. Přitom babička natrhala o 2 hrnky rybízu méně než maminka. Kolik hrnků rybízu natrhaly všechny tři dohromady?'],
     'opts':['A) 18 hrnků','B) 20 hrnků','C) 21 hrnků','D) 23 hrnků','E) 25 hrnků','F) více než 25 hrnků'],'ln':0,
     'sol':['15.1 Zbývá $100\\,\\%-46\\,\\%=54\\,\\%$ z $50$ hrnků, tj. $0{,}54\\cdot 50=27$ hrnků (více než 25) → F.',
            '15.2 Radim $R$, Petr $\\frac{R}{2}$, Slávek i Tomáš $0{,}75R$. Součet $R+\\frac{R}{2}+0{,}75R+0{,}75R=3R=240$, $R=80$. Tomáš $60$, Petr $40$, rozdíl $20$ → B.',
            '15.3 Jitka $J$, maminka $2J$, babička $1{,}5J$. Z $1{,}5J=2J-2$ plyne $J=4$; dohromady $4+8+6=18$ hrnků → A.'],
     'ans':'15.1: F (27 hrnků); 15.2: B (20 hrnků); 15.3: A (18 hrnků)','pts':6,'mins':9,'diff':'4',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2025 – úloha 16','zad':[
        'Vytváříme obrazce tvaru pravidelného šestiúhelníku složené z bílých a šedých shodných rovnostranných trojúhelníků. První obrazec se skládá ze 3 bílých a 3 šedých trojúhelníků a každý další obrazec vznikne přidáním jednoho pásu trojúhelníků okolo předchozího obrazce (viz obrázek).',
        '16.1 Vypočtěte, kolik trojúhelníků (bílých i šedých dohromady) obsahuje poslední přidaný pás 4. obrazce.',
        '16.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý 6. obrazec.',
        '16.3 Určete, kolikátý obrazec má v posledním přidaném pásu 225 šedých trojúhelníků.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'sestiuhelniky.svg',
     'alt':'První, druhý a třetí obrazec tvaru pravidelného šestiúhelníku složené z bílých a šedých rovnostranných trojúhelníků, každý další větší o jeden pás.',
     'cap':'Schematický nákres (1., 2. a 3. obrazec)',
     'sol':['$n$-tý obrazec obsahuje celkem $6n^2$ trojúhelníků (z toho polovina, $3n^2$, šedých). Poslední přidaný pás má $6n^2-6(n-1)^2=6(2n-1)$ trojúhelníků, z toho $3(2n-1)$ šedých.',
            '16.1 Pás 4. obrazce: $6\\cdot(2\\cdot 4-1)=6\\cdot 7=42$ trojúhelníků.',
            '16.2 Šedých v 6. obrazci: $3\\cdot 6^2=108$.',
            '16.3 Řešíme $3(2n-1)=225$, tj. $2n-1=75$, $n=38$; jde o 38. obrazec.'],
     'ans':'16.1: $42$ trojúhelníků; 16.2: $108$ šedých trojúhelníků; 16.3: ve $38.$ obrazci','pts':4,'mins':8,'diff':'4',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD25C0T03'
    gen.YEAR = 2025

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
